require 'formula'

class VruiExamples < Formula
  url 'http://stout.idav.ucdavis.edu/Vrui-2.4-001.tar.gz'
  homepage 'http://keckcaves.org/software/vrui'
  md5 '997deaefb5eb7b0e6f9345493ce1cf42'
  version "2.4-001"

  depends_on 'KeckCAVES/vrui/vrui'

  def install
    args = ["--directory=ExamplePrograms",
            "INSTALLDIR=#{prefix}",
            "VRUI_MAKEDIR=#{HOMEBREW_PREFIX}/share/Vrui-2.4/make"]
    system "make", *args
    system "make", *(args+["install"])
  end
end
