require 'formula'

class Vrui < Formula
  url 'http://keckcaves.org/releases/src/Vrui-2.2-003-1.tar.bz2'
  homepage 'http://keckcaves.org/software/vrui'
  md5 'e1c03da47cc1ab7fff7dbdd7dce0968c'
  version "2.2-003-1"

  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'libusb'

  # Don't strip symbols; need them for dynamic linking.
  skip_clean 'bin'

  def install
    name = "Vrui-2.2"
    args = ["INSTALLDIR=#{prefix}",
            "HEADERINSTALLDIR=#{prefix}/include/#{name}",
            "LIBINSTALLDIR=#{prefix}/lib/#{name}",
            "PLUGININSTALLDIR=#{prefix}/lib/#{name}",
            "ETCINSTALLDIR=#{prefix}/etc/#{name}",
            "SHAREINSTALLDIR=#{prefix}/share/#{name}",
            "DOCINSTALLDIR=#{prefix}/share/doc/#{name}",
            "PNG_BASEDIR=/usr/X11"]
    system "make", *args
    system "make", *(args+["install"])
  end
end
