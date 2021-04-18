# hello world qmake
TEMPLATE += aux
QT -= qt core gui

OTHER_FILES += \
    $$PWD/t1.md

#在qmake语法当中,按定义角色区分有一下三种类型
#1. qmake语言保留的变量 2. 系统环境变量 3. 自定义变量
message("build-in-var":$$PWD)
message("system-env-var":$$(PATH))
self_var=1
message("define-var":$${self_var})

#与传统语言不同，在qmake语法当中，变量是不区分变量类型的
self_var="string"
message("self_var1":$${self_var})
self_var=string
message("self_var2":$${self_var})
self_var += 1 string
message("self_var3":$${self_var})

#Operators
# Empty Values
value=
#1. Assigning Values
value = hello
message("assigning value":$${value})

#2. Appending Values
value += world
message("append value":$${value})

#3. removeing Values
value -= world
message("remove value":$${value})

#4. Adding Unique Values
value *= hello world
message("Adding Unique Values":$${value})

#5. Replacing Values
value ~= s/[l]/L
message("Replacing Values":$${value})
message("Replacing Values":$$[value])

URL=aaa.bbb.ccc

URL ~= s/\./\\

message("URL":$${URL})


#5. Variable Expansion
# 在qmake语法中有三种方式提取一个变量的值
#1. $$var
#2. $$(var)     对于非环境变量无效
#3. $${var}

#6. Accessing qmake Properties
# 可以通过 $$[...]操作符来获取qmake中内置的一些变量值
message(Qt version: $$[QT_VERSION])
message(Qt version: $$(QT_VERSION))
message(Qt version: $$QT_VERSION)
message(Qt version: $${QT_VERSION})
message(Qt is installed in $$[QT_INSTALL_PREFIX])
message(Qt resources can be found in the following locations:)
message(Documentation: $$[QT_INSTALL_DOCS])
message(Header files: $$[QT_INSTALL_HEADERS])
message(Libraries: $$[QT_INSTALL_LIBS])
message(Binary files (executables): $$[QT_INSTALL_BINS])
message(Plugins: $$[QT_INSTALL_PLUGINS])
message(Data files: $$[QT_INSTALL_DATA])
message(Translation files: $$[QT_INSTALL_TRANSLATIONS])
message(Settings: $$[QT_INSTALL_CONFIGURATION])
message(Examples: $$[QT_INSTALL_EXAMPLES])



