namespace :build do
  TARGET = "Collections"
  CONFIG = "Release"
  LIB_NAME = "libCollections.a"
  BUILD_DIR = "build"
  BASE_SDK = 4.2
  
  desc "Build the static library for the simulator platform"
  task :simulator do
    system("xcodebuild -target #{TARGET} -configuration #{CONFIG} -sdk iphonesimulator#{BASE_SDK}")
  end
  
  desc "Build the static library for the device platform"
  task :device do
    system("xcodebuild -target #{TARGET} -configuration #{CONFIG} -sdk iphoneos#{BASE_SDK}")
  end
  
  desc "Build a combined simulator/device library using lipo"
  task :combined => [:simulator, :device] do
    FileUtils.mkdir_p("#{BUILD_DIR}/CombinedLib")
    system("lipo #{BUILD_DIR}/#{CONFIG}-iphonesimulator/#{LIB_NAME} #{BUILD_DIR}/#{CONFIG}-iphoneos/#{LIB_NAME} -create -output #{BUILD_DIR}/CombinedLib/libCollections.a")
  end
  
  desc "Clean the build products directory"
  task :clean do
    system("xcodebuild clean")
  end

  FRAMEWORK_NAME = "Collections.framework"
  
  desc "Create the static framework for the iOS platform"
  task :framework => [:clean, :combined] do
    build_framework("#{BUILD_DIR}/CombinedLib/libCollections.a")
  end
  
  def build_framework(path_to_library)
    FileUtils.rm_rf("#{BUILD_DIR}/Release")
    
    FileUtils.makedirs("#{BUILD_DIR}/Release/#{FRAMEWORK_NAME}/Versions/A/Headers")
    FileUtils.makedirs("#{BUILD_DIR}/Release/#{FRAMEWORK_NAME}/Versions/A/Resources")
    sh("cp #{path_to_library} #{BUILD_DIR}/Release/#{FRAMEWORK_NAME}/Versions/A/Collections")
    sh("ln -s Versions/A/Collections #{BUILD_DIR}/Release/#{FRAMEWORK_NAME}/Collections")
    sh("ln -s Versions/A/Headers #{BUILD_DIR}/Release/#{FRAMEWORK_NAME}/Headers")
    sh("cp Classes/*.h #{BUILD_DIR}/Release/#{FRAMEWORK_NAME}/Versions/A/Headers")
    sh("cp Info.plist #{BUILD_DIR}/Release/#{FRAMEWORK_NAME}/Versions/A/Resources")
  end
end

task :default => "build:framework"
