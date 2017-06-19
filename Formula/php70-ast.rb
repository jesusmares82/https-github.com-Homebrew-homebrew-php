require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ast < AbstractPhp70Extension
  init
  desc "exposing PHP 7 abstract syntax tree"
  homepage "https://github.com/nikic/php-ast"
  url "https://github.com/nikic/php-ast/archive/v0.1.4.tar.gz"
  sha256 "082380202aecca3709b6b67121024f46c06ed5e00ff966f11523ab853491ed54"
  head "https://github.com/nikic/php-ast.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "df5b5723249fa0a9ec8df775836d22d14c79aaa7fcf4914d6c4f126ce4cf0451" => :sierra
    sha256 "4390b2bda0321a5ae8564739ca0f8a3b167242904690d3add00a646dbcaf5af0" => :el_capitan
    sha256 "01f16769082ba04368aea5b47d8779d1d3d068950d44b223ae0e0745596e0745" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/ast.so"
    write_config_file if build.with? "config-file"
  end
end
