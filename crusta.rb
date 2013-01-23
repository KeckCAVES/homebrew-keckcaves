require 'formula'

class Crusta < Formula
  homepage 'http://keckcaves.org/software/crusta'
  url 'https://github.com/KeckCAVES/crusta.git', :revision => '4634bf303d8599aceb03a7bfea9b4912b8d66eb4'
  head 'https://github.com/KeckCAVES/crusta.git'
  version "1.0-69-1"

  depends_on 'cmake' => :build
  depends_on 'pkg-config' => :build
  depends_on 'KeckCAVES/vrui/vrui'
  depends_on 'glew'
  depends_on 'gdal'

  def install
    args = []
    args << "-DPROJECT_VERSION=#{version}"
    args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    args << "-DCMAKE_PREFIX_PATH=#{HOMEBREW_PREFIX}"
    system "cmake", ".", *args
    system "make VERBOSE=1"
    system "make", "install"
  end
end
