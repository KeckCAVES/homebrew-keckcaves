require 'formula'

class VruiExamples < Formula
  url 'http://stout.idav.ucdavis.edu/Vrui-2.4-004.tar.gz'
  homepage 'http://keckcaves.org/software/vrui'
  sha1 '0fd094458489fdf558d08a27d093d2669bbf6783'
  version "2.4-004"

  depends_on 'KeckCAVES/vrui/vrui'

  def install
    args = []
    args << "--directory=ExamplePrograms"
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
