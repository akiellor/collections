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
  
  desc "Build the static library for the Mac platform"
  task :mac do
    system("xcodebuild -target #{TARGET}-Mac -configuration #{CONFIG}")
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
  
  desc "Create the static framework for the Mac platform"
  task :mac_framework => [:clean, :mac] do
    build_framework("#{BUILD_DIR}/Release-Mac/libCollections.a")
  end
  
  desc "Build a disk image for the iOS framework"
  task :diskimage => :framework do
    FileUtils.mkdir_p("pkg")
    system("hdiutil create -srcfolder #{BUILD_DIR}/Release pkg/Collections-#{VERSION}.dmg")
  end
  
  desc "Build a disk image for the Mac framework"
  task :diskimage_mac => :mac_framework do
    FileUtils.mkdir_p("pkg")
    system("hdiutil create -srcfolder #{BUILD_DIR}/Release pkg/Collections-Mac-#{VERSION}.dmg")
  end
  
  def build_framework(path_to_library)
    FileUtils.rm_rf("#{BUILD_DIR}/Release")
    
    system("xcodebuild -target CollectionsFramework -configuration #{CONFIG}")
    system("cp #{path_to_library} #{BUILD_DIR}/Release/#{FRAMEWORK_NAME}/Versions/A/Collections")
    system("ln -s Versions/A/Collections #{BUILD_DIR}/Release/#{FRAMEWORK_NAME}/Collections")
  end
end

task :default => "build:framework"
