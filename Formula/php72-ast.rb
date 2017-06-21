require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Ast < AbstractPhp72Extension
  init
  desc "Exposing PHP 7 abstract syntax tree"
  homepage "https://github.com/nikic/php-ast"
  url "https://github.com/nikic/php-ast/archive/v0.1.4.tar.gz"
  sha256 "082380202aecca3709b6b67121024f46c06ed5e00ff966f11523ab853491ed54"
  head "https://github.com/nikic/php-ast.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5ef11ea6e6a6d9acfdf19ada1a313965764c6a2c86afb3c83302f3069091e422" => :sierra
    sha256 "0ea1f6207ad699c5751748f1de58d8aeba728bd61085299c8fc1aa64125ae141" => :el_capitan
    sha256 "4806864835ddd4618b21108119a44b60fa13aa54a905f364ff892c3b0aa4206f" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/ast.so"
    write_config_file if build.with? "config-file"
  end
end
