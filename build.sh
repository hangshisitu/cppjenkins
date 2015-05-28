BuildPath=./dist
TinyXML=/home/qjxiao/buildenv/tinyxml
CPPCheckReport=cppcheckreport.xml
CPPCheckApp=/home/qjxiao/buildenv/cppcheck-1.69/cppcheck
CPPNCSSReport=cppncssreport.xml
CPPNCSSApp=/home/qjxiao/buildenv/cppncss-1.0.3/bin/cppncss
GCOVReport=gcovreport.xml
GCOVRApp=/home/qjxiao/buildenv/gcovr

SRCDir=./src
RunPath=$BuildPath

GTestReport=gtestreport.xml

echo "clean vod server"
make clean
rm *.gcov > /dev/null
rm $CPPCheckReport > /dev /null
rm -r -f ./cppncss
rm $GCOVReport > /dev /null
rm $GTestReport > /dev /null  

echo "make vod server"
make

if [ -r "$BuildPath" ]; then
     echo "Make Success"
     echo "Make CPPCheck Report $CPPCheckReport"
      $CPPCheckApp -v --enable=all --xml -I $TinyXML $SRCDir  2> $CPPCheckReport

     echo "Make CPPNCSS Report $CPPNCSSReport"
      mkdir ./cppncss > /dev/null
      $CPPNCSSApp -r -v -x -k -f=./cppncss /$CPPNCSSReport $SRCDir
     
     echo "Run Test Program, Make Test Report"
     $RunPath/test --gtest_output=xml:$GTestReport > /dev /null
     
     echo "Make GCovr"
     $GCOVRApp -x -r . > $GCOVReport
else
     echo "Make Fail!"
fi