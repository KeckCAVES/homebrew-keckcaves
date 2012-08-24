require 'formula'

class VruiExamples < Formula
  url 'http://stout.idav.ucdavis.edu/Vrui-2.4-002.tar.gz'
  homepage 'http://keckcaves.org/software/vrui'
  sha1 '0fcbca4d4a51fe4a39ed7ecd49d19c7a0fa9c110'
  version "2.4-002"

  depends_on 'KeckCAVES/vrui/vrui'

  def install
    args = ["--directory=ExamplePrograms",
            "INSTALLDIR=#{prefix}",
            "VRUI_MAKEDIR=#{HOMEBREW_PREFIX}/share/Vrui-2.4/make"]
    system "make", *args
    system "make", *(args+["install"])
  end
end
