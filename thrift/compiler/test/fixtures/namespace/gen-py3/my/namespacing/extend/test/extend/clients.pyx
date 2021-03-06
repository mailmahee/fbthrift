#
# Autogenerated by Thrift
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#  @generated
#
from libcpp.memory cimport shared_ptr, make_shared, unique_ptr, make_unique
from libcpp.string cimport string
from libcpp cimport bool as cbool
from cpython cimport bool as pbool
from libc.stdint cimport int8_t, int16_t, int32_t, int64_t
from libcpp.vector cimport vector as vector
from libcpp.set cimport set as cset
from libcpp.map cimport map as cmap
from cython.operator cimport dereference as deref
from cpython.ref cimport PyObject
from thrift.py3.client cimport EventBase, make_py3_client, py3_get_exception
from thrift.py3.client import get_event_base
from thrift.py3.folly cimport cFollyEventBase, cFollyTry, cFollyUnit, c_unit

import asyncio
import sys
import traceback

cimport my.namespacing.extend.test.extend.types
import my.namespacing.extend.test.extend.types

from my.namespacing.extend.test.extend.clients_wrapper cimport move
cimport hsmodule.types
import hsmodule.types
cimport hsmodule.clients
import hsmodule.clients

from my.namespacing.extend.test.extend.clients_wrapper cimport cExtendTestServiceAsyncClient, cExtendTestServiceClientWrapper
from hsmodule.clients_wrapper cimport cHsTestServiceClientWrapper


cdef void ExtendTestService_check_callback(
        PyObject* future,
        cFollyTry[cbool] result) with gil:
    cdef object pyfuture = <object> future
    cdef cbool citem
    if result.hasException():
        try:
            result.exception().throwException()
        except:
            pyfuture.loop.call_soon_threadsafe(pyfuture.set_exception, sys.exc_info()[1])
    else:
        citem = result.value();
        pyfuture.loop.call_soon_threadsafe(pyfuture.set_result, citem)


cdef class ExtendTestService(hsmodule.clients.HsTestService):

    def __init__(self, *args, **kwds):
        raise TypeError('Use ExtendTestService.connect() instead.')

    def __cinit__(self, loop):
        self.loop = loop

    @staticmethod
    cdef _extend_ExtendTestService_set_client(ExtendTestService inst, shared_ptr[cExtendTestServiceClientWrapper] c_obj):
        """So the class hierarchy talks to the correct pointer type"""
        inst._extend_ExtendTestService_client = c_obj
        hsmodule.clients.HsTestService._hsmodule_HsTestService_set_client(inst, <shared_ptr[cHsTestServiceClientWrapper]>c_obj)

    @staticmethod
    async def connect(str host, int port, loop=None):
        loop = loop or asyncio.get_event_loop()
        future = loop.create_future()
        future.loop = loop
        eb = await get_event_base(loop)
        cdef string _host = host.encode('UTF-8')
        make_py3_client[cExtendTestServiceAsyncClient, cExtendTestServiceClientWrapper](
            (<EventBase> eb)._folly_event_base,
            _host,
            port,
            0,
            made_ExtendTestService_py3_client_callback,
            future)
        return await future

    def check(
            self,
            arg_struct1):
        future = self.loop.create_future()
        future.loop = self.loop

        deref(self._extend_ExtendTestService_client).check(
            deref((<hsmodule.types.HsFoo>arg_struct1).c_HsFoo),
            ExtendTestService_check_callback,
            future)
        return future


cdef void made_ExtendTestService_py3_client_callback(
        PyObject* future,
        cFollyTry[shared_ptr[cExtendTestServiceClientWrapper]] result) with gil:
    cdef object pyfuture = <object> future
    if result.hasException():
        try:
            result.exception().throwException()
        except:
            pyfuture.loop.call_soon_threadsafe(pyfuture.set_exception, sys.exc_info()[1])
    else:
        pyclient = <ExtendTestService> ExtendTestService.__new__(ExtendTestService, pyfuture.loop)
        ExtendTestService._extend_ExtendTestService_set_client(pyclient, result.value())
        pyfuture.loop.call_soon_threadsafe(pyfuture.set_result, pyclient)

