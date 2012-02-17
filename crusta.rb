require 'formula'

class Crusta < Formula
  homepage 'http://keckcaves.org/software/crusta'
  url 'https://github.com/KeckCAVES/crusta.git', :tag => 'b7513a89c5a20c288b0a224007a9ad0ebfa8f226'
  version "1.0.1"

  depends_on 'cmake' => :build
#  depends_on 'vrui'
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
