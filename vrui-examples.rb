require 'formula'

class VruiExamples < Formula
  url 'http://stout.idav.ucdavis.edu/Vrui-2.4-003.tar.gz'
  homepage 'http://keckcaves.org/software/vrui'
  sha1 '6a50017c2102bbb81623a1819475696108fb7b9d'
  version "2.4-003"

  depends_on 'KeckCAVES/vrui/vrui'

  def install
    args = ["--directory=ExamplePrograms",
            "INSTALLDIR=#{prefix}",
            "VRUI_MAKEDIR=#{HOMEBREW_PREFIX}/share/Vrui-2.4/make"]
    system "make", *args
    system "make", *(args+["install"])
  end
end
