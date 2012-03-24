require 'formula'

class Nck < Formula
  url 'http://stout.idav.ucdavis.edu/NCK-1.6.tar.gz'
  homepage 'http://keckcaves.org/software/nck'
  md5 'a2588408d118f063940541937a82319a'

  depends_on 'KeckCAVES/vrui/vrui'

  def install
    args = ["INSTALLDIR=#{prefix}",
            "VRUI_MAKEDIR=#{HOMEBREW_PREFIX}/share/Vrui-2.2/make"]
    system "make", *args
    system "make", *(args+["install"])
  end
end
