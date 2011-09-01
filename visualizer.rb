# This is named 'visualizer' and not '3dvisualizer' only because
# of limitations in class naming between ruby and homebrew.

require 'formula'

class Visualizer < Formula
  url 'http://stout.idav.ucdavis.edu/3DVisualizer-1.8.tar.gz'
  homepage 'http://keckcaves.org/software/3dvisualizer'
  md5 '26b974fd35bae29cc7f57cd96579c489'

#  depends_on 'vrui'

  def options
    [['--use-shaders', "Use GLSL shaders instead of fixed OpenGL functionality\n\tfor some visualization algorithms, especially volume rendering.\n\tThis flag should only be set on newer, dedicated 3D graphics cards\n\tsuch as Nvidia's G80 series."]]
  end
  
  def install
    inreplace 'makefile', 'UNSUPPORTED_MODULE_NAMES =', 'MODULE_NAMES +='
    if ARGV.include? '--use-shaders'
      shdr = 1
      ohai 'Will use GLSL shaders'
    else
      shdr = 0
    end
    system "make", "INSTALLDIR=#{prefix}", "VRUIDIR=#{HOMEBREW_PREFIX}", "USE_SHADERS=#{shdr}"
    system "make", "INSTALLDIR=#{prefix}", "VRUIDIR=#{HOMEBREW_PREFIX}", "USE_SHADERS=#{shdr}", "install"
  end

  def caveats; <<-EOS.undent
    Please note that the name of the installed executable is "3DVisualizer".
    EOS
  end
end
