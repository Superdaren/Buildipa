 #!/bin/bash   
   
#将该文件放到和workspace同目录下
 
#100路径，根据自己的服务器路径写
path100_lastExtension=''
path100=''
pathSmb100=''

 #IPA名称  
var=`date "+_%m%d_%H%M"`
ipa_name="tbEmoji_1.6.1_1014_test_$var"

 if [ $# == 0 ];then  #不带参数，则上传100，带参数则仅编译打包。参数随意。。
  if [ -d ${path100_lastExtension} ]; then
    echo "100路径已打开...开始编译"
  else
    if [ -d ${path100} ]; then
      echo "100路径已打开...开始编译"
    else
    open ${pathSmb100};
     
    echo "正在等待100目录打开。。打开后请重新执行脚本"
    exit
    fi
  fi
fi

xcodebuild -workspace tbEmoji.xcworkspace -scheme tbEmojiGuangchang -configuration Debug archive -archivePath ./build/tbEmoji || exit

#打包
rm -rf ./build/*.ipa  
xcodebuild -exportArchive -exportFormat ipa -archivePath ./build/tbEmoji.xcarchive -exportPath ./build/${ipa_name}.ipa -exportProvisioningProfile 'biaoqing_dev' || exit


#上传100
if [ $# == 0 ];then
  if [ -d ${path100_lastExtension} ]; then

    mkdir ${path100_lastExtension}/old
    mv ${path100_lastExtension}/*.ipa ${path100_lastExtension}/old/

    cp ./build/${ipa_name}.ipa ${path100_lastExtension}
    finalPath="$pathSmb100/$ipa_name"
    echo "ipa包已传到:$finalPath"
  else
    if [ -d ${path100} ]; then

    mkdir ${path100}/old
    mv ${path100}/*.ipa ${path100}/old/

      cp ./build/${ipa_name}.ipa ${path100}
      finalPath="$pathSmb100/$ipa_name"
      echo "ipa包已传到:$finalPath"
    else
    open ${pathSmb100};
    open ./build;
    echo "正在等待100目录打开。。请手动上传"
    fi
  fi
fi



