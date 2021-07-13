TEMPLATE += aux
QT -= qt gui core

OTHER_FILES += \
    $$PWD/t3.md

# qmake函数介绍
#代码复用是提高代码编写必不可少的要素，那么如何将一段代码封装成一个模块呢?这就是函数的作用了。

#与其它语言只有一种函数不同的是，qmake有两种函数类型。
#1. Replace Funcions
#  定义 Replace Funcation
#  返回一个值、列表或者不返回
#  defineReplace(functionName){
#      #args: $$1 $$2 $$3 ...
#      #all args list: $$ARGS
#      #function body
#      #[return(ret)]
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

defineReplace(libraryNameSuffix){
    suffix=
    CONFIG(debug, release|debug){
        !debug_and_release|build_pass{
            mac: return($${suffix}_debug)
            win32: return($${suffix}d)
        }
    }
    return($$suffix)
}
# $1: libaray name
defineReplace(librayName){
    isEmpty(1){         #使用参数作为另一个函数的实参时无需扩展($$)，除非函数实参需要的是字符串
        error("The library name can not be empty")
    }
    LIB_NAME=$$1
    CONFIG(shared, shared|static):qtConfig(framework){
      QMAKE_FRAMEWORK_BUNDLE_NAME = $$LIBRARY_NAME
      export(QMAKE_FRAMEWORK_BUNDLE_NAME)
    }

    return($$LIB_NAME$$libraryNameSuffix())
}
message("function result": $$librayName(demo))

defineReplace(printArgsCount){
    listCount=0
    message("arg var:": $$ARGS)
    for(i, ARGS){
        listCount = $$num_add($$listCount, 1)
    }
    return($$listCount)
}
message("args  count:":$$printArgsCount(a,b,c,d))

#可以在函数内局部变量导出变量到全局中(达到一种类似于pass by reference 的作用)
# export(RET)
defineReplace(exportVariable){
    isEmpty(1){
        return("")
    }
    $$1=newVar
    export($$1)
}
var=oldVar
retVar=$$exportVariable("var")
message("export var:":$$var)

#2. Test Funcation
#  定义 Test Funcation
#  必须返回 true 或 false
#  defineTest(functionName){
#      #args: $$1 $$2 $$3 ...
#      #all args: $$ARGS
#      #function body
#      #<return({true,false})>
#  }
#

defineTest(checkAllFiles) {
  for(file, ARGS) {
      !exists($$file) {
          return(false)
      }
  }
  return(true)
}
checkAllFiles($$PWD/t3.md, $$PWD/t4.md){
    message("All files exist")
}else{
    message("Some files do not exist")
}



#---
#some built-in funcation
file=$$PWD/t3.md
message("absolute_path":$$absolute_path(file))

message("basename":$$basename(file))

message("clean_path":$$clean_path("aaa\bbb/sss\\eeee"))

message("First line$$escape_expand(\\n)Second line")
message("First line\\nSecond line")
message("First line\nSecond line")

message("format_number":$$format_number(11, ibase=16 width=6 zeropad))
message($$BAD)

message("PWD:": $$PWD)
message("_PRO_FILE_PWD_:": $$_PRO_FILE_PWD_)
