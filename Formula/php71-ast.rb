require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ast < AbstractPhp71Extension
  init
  desc "Exposing PHP 7 abstract syntax tree"
  homepage "https://github.com/nikic/php-ast"
  url "https://github.com/nikic/php-ast/archive/v0.1.5.tar.gz"
  sha256 "a1fcc1c9a2c48a1bda5d3f18a8616e3964c25d4d10a23d9f97fb2af46712e42e"
  head "https://github.com/nikic/php-ast.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "41a608abc2054eb4f216214c48bd41b8c0a5fb9620cc59c35cc2d05ac0ca5b0d" => :sierra
    sha256 "c0d310f3cbd12565564ecee5cf0e59e9f9dff6290bbfed7adcfdce6ce4bc1951" => :el_capitan
    sha256 "3af4bfac32cb6a97b31b8b641de05d88bfa1d8dac7910db0d0629b87de262d2c" => :yosemite
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
