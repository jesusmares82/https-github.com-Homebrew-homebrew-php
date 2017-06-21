require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Ast < AbstractPhp72Extension
  init
  desc "Exposing PHP 7 abstract syntax tree"
  homepage "https://github.com/nikic/php-ast"
  url "https://github.com/nikic/php-ast/archive/v0.1.4.tar.gz"
  sha256 "082380202aecca3709b6b67121024f46c06ed5e00ff966f11523ab853491ed54"
  head "https://github.com/nikic/php-ast.git"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/ast.so"
    write_config_file if build.with? "config-file"
  end
end
