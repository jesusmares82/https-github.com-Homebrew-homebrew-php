require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ast < AbstractPhp70Extension
  init
  desc "exposing PHP 7 abstract syntax tree"
  homepage "https://github.com/nikic/php-ast"
  url "https://github.com/nikic/php-ast/archive/v0.1.1.tar.gz"
  sha256 "85ecc69fa9ba777c1ee6218f5afcc78e13f9c0506b147a6c173a5976c9977967"
  head "https://github.com/nikic/php-ast.git"

  bottle do
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
