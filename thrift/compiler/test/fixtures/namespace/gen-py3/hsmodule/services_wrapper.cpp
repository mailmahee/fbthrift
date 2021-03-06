/**
 * Autogenerated by Thrift
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *  @generated
 */

#include <gen-py3/hsmodule/services_wrapper.h>
#include <gen-py3/hsmodule/services_api.h>
#include <thrift/lib/cpp2/async/AsyncProcessor.h>

namespace cpp2 {

HsTestServiceWrapper::HsTestServiceWrapper(PyObject *obj)
  : if_object(obj)
  {
    import_hsmodule__services();
    Py_XINCREF(this->if_object);
  }

HsTestServiceWrapper::~HsTestServiceWrapper() {
    Py_XDECREF(this->if_object);
}

folly::Future<int64_t> HsTestServiceWrapper::future_init(
  int64_t int1
) {
  folly::Promise<int64_t> promise;
  auto future = promise.getFuture();
  call_cy_HsTestService_init(
    this->if_object,
    std::move(promise),
    int1
  );
  return future;
}

std::shared_ptr<apache::thrift::ServerInterface> HsTestServiceInterface(PyObject *if_object) {
  return std::make_shared<HsTestServiceWrapper>(if_object);
}
} // namespace cpp2
