require 'formula'

class Vrui < Formula
  url 'http://stout.idav.ucdavis.edu/Vrui-2.4-004.tar.gz'
  homepage 'http://keckcaves.org/software/vrui'
  sha1 '0fd094458489fdf558d08a27d093d2669bbf6783'
  version "2.4-004"

  depends_on :x11 => '2.7.4'
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'libusb'

  # Don't strip symbols; need them for dynamic linking.
  skip_clean 'bin'

  def install
    name = "Vrui-2.4"
    args = []
    args << "INSTALLDIR=#{prefix}"
    args << "HEADERINSTALLDIR=#{prefix}/include/#{name}"
    args << "LIBINSTALLDIR=#{prefix}/lib/#{name}"
    args << "PLUGININSTALLDIR=#{prefix}/lib/#{name}"
    args << "ETCINSTALLDIR=#{prefix}/etc/#{name}"
    args << "SHAREINSTALLDIR=#{prefix}/share/#{name}"
    args << "DOCINSTALLDIR=#{prefix}/share/doc/#{name}"
    args << "PNG_BASEDIR=#{MacOS::X11.prefix}"
    args << "X11_BASEDIR=#{MacOS::X11.prefix}"
    args << "GL_BASEDIR=#{MacOS::X11.prefix}"
    args << "GLU_BASEDIR=#{MacOS::X11.prefix}"
    system "make", *args
    system "make", *(args+["install"])
  end
end
