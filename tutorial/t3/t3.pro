TEMPLATE += aux
QT -= qt gui core

OTHER_FILES += \
    $$PWD/t3.md

# qmake函数介绍
#代码复用是提高代码编写必不可少的要素，那么如何将一段代码封装成一个模块呢?这就是函数的作用了。

#与其它语言只有一种函数不同的是，qmake有两种函数类型。
#1. Replace Funcions
#  定义 Replace 函数
#  返回一个值、列表或者不返回
#  defineReplace(functionName){
#      #function code
#  }
#
defineReplace(headersAndSources) {
  variable = $$1
  names = $$eval($$variable)
  headers =
  sources =

  for(name, names) {
      header = $${name}.h
      exists($$header) {
          headers += $$header
      }
      source = $${name}.cpp
      exists($$source) {
          sources += $$source
      }
  }
  return($$headers $$sources)
}

# $1: libaray name
defineReplace(libarayName){
    SUFFIX=
    LIBNAME=$$1
    RET=
    CONFIG(debug, debug|release):SUFFIX=_d
    win32{
        RET = $${LIBNAME}$${SUFFIX}.lib
    }else:unix{
        RET = $${LIBNAME}$${SUFFIX}.a
    }else{
        error("Unkonw Platform")
    }
    return ($$RET)

}

message("function result": $$libarayName(test))
#可以在函数内到处变量 export(RET)
message("RET":$$RET)

#2. 定义 Test 函数
#  定义 Test 函数
#  必须返回 true 或 false
#  defineTest(functionName){
#      #function code
#      return (true)    #return (false)
#  }
#

  defineTest(allFiles) {
      files = $$ARGS

      for(file, files) {
          !exists($$file) {
              return(false)
          }
      }
      return(true)
  }


#---
file=$$PWD/t3.md
message("absolute_path":$$absolute_path(file))

message("basename":$$basename(file))

message("clean_path":$$clean_path("aaa\bbb/sss\\eeee"))

message("First line$$escape_expand(\\n)Second line")
message("First line\\nSecond line")
message("First line\nSecond line")

message("format_number":$$format_number(11, ibase=16 width=6 zeropad))
message($$BAD)
