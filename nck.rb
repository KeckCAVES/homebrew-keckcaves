require 'formula'

class Nck < Formula
  url 'http://stout.idav.ucdavis.edu/NCK-1.7.tar.gz'
  homepage 'http://keckcaves.org/software/nck'
  md5 'fe21c27b63e84ec10ca57796d692c3b7'

  depends_on 'KeckCAVES/vrui/vrui'

  def install
    args = []
    args << "INSTALLDIR=#{prefix}"
    args << "VRUI_MAKEDIR=#{HOMEBREW_PREFIX}/share/Vrui-2.4/make"
    args << "JPEG_BASEDIR=#{HOMEBREW_PREFIX}"
    args << "TIFF_BASEDIR=#{HOMEBREW_PREFIX}"
    args << "LIBUSB1_BASEDIR=#{HOMEBREW_PREFIX}"
    args << "PNG_BASEDIR=#{MacOS::X11.prefix}"
    args << "X11_BASEDIR=#{MacOS::X11.prefix}"
    args << "GL_BASEDIR=#{MacOS::X11.prefix}"
    args << "GLU_BASEDIR=#{MacOS::X11.prefix}"
    args << "SHOWCOMMAND=1"
    system "make", *args
    system "make", *(args+["install"])
  end
end
