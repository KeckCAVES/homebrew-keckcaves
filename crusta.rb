require 'formula'

class Crusta < Formula
  ver = "1.0-69-g4634bf3"
  pkgver = "1"
  src = "https://github.com/KeckCAVES/crusta.git"

  homepage "http://keckcaves.org/software/crusta"
  url src, :revision => ver 
  head src
  version "#{ver}-#{pkgver}"

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
