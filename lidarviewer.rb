require 'formula'

class Lidarviewer < Formula
  url 'http://stout.idav.ucdavis.edu/LidarViewer-2.9.tar.gz'
  homepage 'http://keckcaves.org/software/lidarviewer'
  md5 'ddbdf33e2a9e662e0abee1bcd2ff9595'

  depends_on 'KeckCAVES/vrui/vrui'

  def install
    args = []
    args << "INSTALLDIR=#{prefix}"
    args << "VRUI_MAKEDIR=#{HOMEBREW_PREFIX}/share/Vrui-2.4/make"
    args << "PNG_BASEDIR=#{MacOS::X11.prefix}"
    args << "X11_BASEDIR=#{MacOS::X11.prefix}"
    args << "GL_BASEDIR=#{MacOS::X11.prefix}"
    args << "GLU_BASEDIR=#{MacOS::X11.prefix}"
    system "make", *args
    system "make", *(args+["install"])
  end
end
