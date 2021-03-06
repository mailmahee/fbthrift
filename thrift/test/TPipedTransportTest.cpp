/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

#include <cstdlib>
#include <stdexcept>
#include <Thrift.h>
#include <transport/TTransportUtils.h>
#include <transport/TBufferTransports.h>
using namespace std;
using std::shared_ptr;
using apache::thrift::transport::TTransportException;
using apache::thrift::transport::TPipedTransport;
using apache::thrift::transport::TMemoryBuffer;

int main() {
  shared_ptr<TMemoryBuffer> underlying(new TMemoryBuffer);
  shared_ptr<TMemoryBuffer> pipe(new TMemoryBuffer);
  shared_ptr<TPipedTransport> trans(new TPipedTransport(underlying, pipe));

  uint8_t buffer[4];

  underlying->write((uint8_t*)"abcd", 4);
  trans->readAll(buffer, 2);
  assert( string((char*)buffer, 2) == "ab" );
  trans->readEnd();
  assert( pipe->getBufferAsString() == "ab" );
  pipe->resetBuffer();
  underlying->write((uint8_t*)"ef", 2);
  trans->readAll(buffer, 2);
  assert( string((char*)buffer, 2) == "cd" );
  trans->readAll(buffer, 2);
  assert( string((char*)buffer, 2) == "ef" );
  trans->readEnd();
  assert( pipe->getBufferAsString() == "cdef" );

  return 0;

}
