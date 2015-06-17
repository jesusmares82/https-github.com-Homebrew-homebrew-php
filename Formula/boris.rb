require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Boris < Formula
  desc "A tiny REPL for PHP"
  homepage "https://github.com/borisrepl/boris/"
  url "https://github.com/borisrepl/boris/archive/v1.0.10.tar.gz"
  sha256 "06eb9e8efe5ceac00f49ba32731c65047435ab09ff57bbbec56c8c728861a2ee"
  head "https://github.com/borisrepl/boris.git"

  depends_on PhpMetaRequirement
  depends_on "composer" => :build
  depends_on "php53" if Formula["php53"].linked_keg.exist?
  depends_on "php54" if Formula["php54"].linked_keg.exist?
  depends_on "php55" if Formula["php55"].linked_keg.exist?
  depends_on "php56" if Formula["php56"].linked_keg.exist?

  def install
    system "composer", "install"
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/boris"
  end

  def caveats
    <<-EOS.undent
    Boris depends on the following PHP features:
      * PHP >= 5.3
      * The Readline functions
      * The PCNTL functions
      * The POSIX functions
    EOS
  end

  test do
    system "boris", "-h"
  end
end
