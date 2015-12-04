require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ast < AbstractPhp70Extension
  init
  desc "exposing PHP 7 abstract syntax tree"
  homepage "https://github.com/nikic/php-ast"
  url "https://github.com/nikic/php-ast/archive/v0.1.1.tar.gz"
  sha256 "85ecc69fa9ba777c1ee6218f5afcc78e13f9c0506b147a6c173a5976c9977967"
  head "https://github.com/nikic/php-ast.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "d5089ee03c435c89f72c21fcc2e9b44df4f293a0a86efac811a6872a88c72640" => :el_capitan
    sha256 "5c629e0bb14b12bea539ae4df18b4de72f44caa84e5f44fabdf463c8d92e8fec" => :yosemite
    sha256 "a703473ae1a241b7d65c8ba8202aa753549eee28cfef9c9389124023ee1fa861" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/ast.so"
    write_config_file if build.with? "config-file"
  end
end
