require 'formula'

class Vrui < Formula
  ver = "3.1-002"
  pkgver = "1"

  homepage 'http://keckcaves.org/software/vrui'
  url "https://github.com/KeckCAVES/Vrui.git", :revision => "v#{ver}"
  version "#{ver}-#{pkgver}"

  depends_on :x11 => '2.7.4'
  depends_on :libpng
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'libusb'

  # Don't strip symbols; need them for dynamic linking.
  skip_clean 'bin'

  def install
    args = []

    args << "INSTALLDIR=#{prefix}"
    args << "DOCINSTALLDIR=#{doc}"
    args << "ETCINSTALLDIR=#{etc}/#{name}"
    args << "EXECUTABLEINSTALLDIR=#{bin}"
    args << "HEADERINSTALLDIR=#{include}/#{name}"
    args << "LIBINSTALLDIR=#{lib}/#{name}"
    args << "PKGCONFIGINSTALLDIR=#{lib}/pkgconfig"
    args << "PLUGININSTALLDIR=#{lib}/#{name}"
    args << "SHAREINSTALLDIR=#{share}/#{name}"

    args << "JPEG_BASEDIR=#{HOMEBREW_PREFIX}"
    args << "TIFF_BASEDIR=#{HOMEBREW_PREFIX}"
    args << "LIBUSB1_BASEDIR=#{HOMEBREW_PREFIX}"
    args << "PNG_BASEDIR=#{(MacOS.version >= :mountain_lion) ? HOMEBREW_PREFIX : MacOS::X11.prefix}"
    args << "X11_BASEDIR=#{MacOS::X11.prefix}"
    args << "GL_BASEDIR=#{MacOS::X11.prefix}"
    args << "GLU_BASEDIR=#{MacOS::X11.prefix}"

    args << "SHOWCOMMAND=1"

    system "make", *args
    system "make", *(args+["install"])
  end
end
