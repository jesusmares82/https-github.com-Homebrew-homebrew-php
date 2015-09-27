require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Sqlformat < AbstractPhpPhar
  init
  desc "CLI adaptation of the SqlFormatter library"
  homepage "https://github.com/MattKetmo/sqlformat"
  url "https://github.com/MattKetmo/sqlformat/releases/download/v1.0.0/sqlformat.phar"
  version "1.0.0"
  sha256 "57eecf761142091424a96a651d537229edee686741f412c6b19201e3f3792914"

  test do
    system "sqlformat", "--version"
  end
end
