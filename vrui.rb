require 'formula'

class Vrui < Formula
  url 'http://stout.idav.ucdavis.edu/Vrui-2.4-003.tar.gz'
  homepage 'http://keckcaves.org/software/vrui'
  sha1 '6a50017c2102bbb81623a1819475696108fb7b9d'
  version "2.4-003"

  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'libusb'

  # Don't strip symbols; need them for dynamic linking.
  skip_clean 'bin'

  def install
    name = "Vrui-2.4"
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
