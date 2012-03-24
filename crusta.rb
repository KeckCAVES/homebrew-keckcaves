require 'formula'

class Crusta < Formula
  homepage 'http://keckcaves.org/software/crusta'
  url 'https://github.com/KeckCAVES/crusta.git', :tag => '89a80e5ebfa3ab8224bbded84043b794c4a1c0cf'
  version "1.0.0"

  depends_on 'cmake' => :build
  depends_on 'KeckCAVES/vrui/vrui'
  depends_on 'gdal'

  def install
    args = []
    args << "-DCMAKE_BUILD_TYPE=Release"
    args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    args << "-DCMAKE_PREFIX_PATH=#{HOMEBREW_PREFIX}"
    args << "-DVRUI_MAKEINCLUDE=#{HOMEBREW_PREFIX}/share/Vrui-2.2/Vrui.makeinclude"
    system "cmake", "build", *args
    system "make"
    system "make", "install"
  end
end
