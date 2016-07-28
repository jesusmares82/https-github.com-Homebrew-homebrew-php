require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ast < AbstractPhp71Extension
  init
  desc "Exposing PHP 7 abstract syntax tree"
  homepage "https://github.com/nikic/php-ast"
  url "https://github.com/nikic/php-ast/archive/v0.1.2.tar.gz"
  sha256 "3c22f06354e249324384497af56635d06666c9d2108f52ba79a86e5807246496"
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
