require 'formula'

class Crusta < Formula
  homepage 'http://keckcaves.org/software/crusta'
  url 'https://github.com/KeckCAVES/crusta.git', :revision => '49a5ae6049178603b4fe1f0f51cb5fcbbfb79fd2'
  head 'https://github.com/KeckCAVES/crusta.git'
  version "1.0.0-2"

  depends_on 'cmake' => :build
  depends_on 'KeckCAVES/vrui/vrui'
  depends_on 'gdal'

  option 'enable-slicing', 'Enable the slicing tool, which may slow down or break other things'

  def install
    args = []
    args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    args << "-DCMAKE_PREFIX_PATH=#{HOMEBREW_PREFIX}"
    args << "-DCRUSTA_SLICING=ON" if build.include? 'enable-slicing'
    system "cmake", ".", *args
    system "make"
    system "make", "install"
  end
end
