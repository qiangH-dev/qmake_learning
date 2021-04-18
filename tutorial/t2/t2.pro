TEMPLATE += aux
QT -= qt gui core

OTHER_FILES += \
    $$PWD/t2.md


# qmake 流程控制介绍
#和一般传统的语言的流程控制语句为条件判断语句和循环语句一样，在qmake中也有着两种控制语句
#1. 条件语句
# note:左大括号必须与条件在同一行
CONFIG(debug, debug|release){
    message("debug mode")
}

win32{
    local_var1 = 1
    message("This is a conditional statement")
}
message("local var1":$$local_var1)
win32:local_var2=2
message("local var2":$$local_var2)

unix{
    message("condtion is true")
}else{
    message("conditon is false")
}



# 类似于
# if(){
# }
# else if(){
# }
# else{
# }
unix{
    message("Unix Platform")
}else:macx{
    message("Mac os Platform")
}else{
    message("Other Plartform")
}

#AND 操作符
win32:message("AND operator")
#OR 操作符
win32|macx{
    message("OR operator")
}

#2.循环控制语句
lists = 1 2 3 4
for(loop , lists){
    message("loop":$$loop)
}
