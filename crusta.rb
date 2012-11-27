require 'formula'

class Crusta < Formula
  homepage 'http://keckcaves.org/software/crusta'
  url 'https://github.com/KeckCAVES/crusta.git', :revision => '69e7499291d4e9b660af23a42f892ca0c662e39c'
  head 'https://github.com/KeckCAVES/crusta.git'
  version "1.0.0-3"

  depends_on 'cmake' => :build
  depends_on 'KeckCAVES/vrui/vrui'
  depends_on 'gdal'

  option 'enable-slicing', 'Enable building crusta-slicing application in addition to crusta'

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
