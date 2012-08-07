require 'formula'

class Nck < Formula
  url 'http://stout.idav.ucdavis.edu/NCK-1.7.tar.gz'
  homepage 'http://keckcaves.org/software/nck'
  md5 'fe21c27b63e84ec10ca57796d692c3b7'

  depends_on 'KeckCAVES/vrui/vrui'

  def install
    args = ["INSTALLDIR=#{prefix}",
            "VRUI_MAKEDIR=#{HOMEBREW_PREFIX}/share/Vrui-2.4/make"]
    system "make", *args
    system "make", *(args+["install"])
  end
end
