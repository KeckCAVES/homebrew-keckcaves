# This is named 'visualizer' and not '3dvisualizer' only because
# of limitations in class naming between ruby and homebrew.

require 'formula'

class Visualizer < Formula
  url 'http://stout.idav.ucdavis.edu/3DVisualizer-1.9.tar.gz'
  homepage 'http://keckcaves.org/software/3dvisualizer'
  md5 'b2bacfac06a30275a27e41ff14442540'

  depends_on 'KeckCAVES/vrui/vrui'

  # Don't strip symbols; need them for dynamic linking.
  skip_clean 'bin'

  def options
    [['--no-shaders',
      "Use fixed OpenGL functionality instead of GLSL shaders\n\t"\
      "for some visualization algorithms, especially volume rendering.\n\t"\
      "This flag should only be set for use on less powerful graphics hardware."]]
  end
  
  def install
    inreplace 'makefile', 'UNSUPPORTED_MODULE_NAMES =', 'MODULE_NAMES +='
    if ARGV.include? '--no-shaders'
      shdr = 0
      ohai 'Will not use GLSL shaders'
    else
      shdr = 1
    end
    args = ["INSTALLDIR=#{prefix}",
            "VRUI_MAKEDIR=#{HOMEBREW_PREFIX}/share/Vrui-2.2/make",
            "USE_SHADERS=#{shdr}"]
    system "make", *args
    system "make", *(args+["install"])
  end

  def caveats; <<-EOS.undent
    Please note that the name of the installed executable is "3DVisualizer".
    EOS
  end
end
