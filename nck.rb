require 'formula'

class Nck < Formula
  url 'http://stout.idav.ucdavis.edu/NCK-1.5.tar.gz'
  homepage 'http://keckcaves.org/software/nck'
  md5 '66ff6ad59cda246829f204a3523095e3'

#  depends_on 'vrui'

  def install
    system "make", "INSTALLDIR=#{prefix}", "VRUIDIR=#{HOMEBREW_PREFIX}"
    system "make", "INSTALLDIR=#{prefix}", "VRUIDIR=#{HOMEBREW_PREFIX}", "install"
  end
end
