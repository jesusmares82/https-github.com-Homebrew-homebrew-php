require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Psysh < Formula
  desc "PsySH is a runtime developer console, interactive debugger & REPL for PHP"
  homepage "https://github.com/bobthecow/psysh"
  url "https://github.com/bobthecow/psysh/archive/v0.5.2.tar.gz"
  sha256 "66cc4ccb4ae864fca6a7e6bb4be7da60bb9d9227da8c9770cd7b4137acc92822"
  head "https://github.com/bobthecow/psysh.git"

  depends_on PhpMetaRequirement
  depends_on "composer" => :build
  depends_on "php53" if Formula["php53"].linked_keg.exist?
  depends_on "php54" if Formula["php54"].linked_keg.exist?
  depends_on "php55" if Formula["php55"].linked_keg.exist?
  depends_on "php56" if Formula["php56"].linked_keg.exist?
  depends_on "php70" if Formula["php70"].linked_keg.exist?

  def install
    system "composer", "install", "--no-dev"
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/psysh"
  end

  test do
    system "psysh", "--version"
  end
end
