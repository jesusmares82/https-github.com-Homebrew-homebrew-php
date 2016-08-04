require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ast < AbstractPhp71Extension
  init
  desc "Exposing PHP 7 abstract syntax tree"
  homepage "https://github.com/nikic/php-ast"
  url "https://github.com/nikic/php-ast/archive/v0.1.2.tar.gz"
  sha256 "3c22f06354e249324384497af56635d06666c9d2108f52ba79a86e5807246496"
  head "https://github.com/nikic/php-ast.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "37633216bbebb26d0fc80deef8832a1fcaf2f253311e9f320a4e4bf207d8001e" => :el_capitan
    sha256 "20c032d27bd5c019935e2d59b043602a44d399a27a91bd946b5e4646dba38f4a" => :yosemite
    sha256 "f579e191723799980ed1a7fd28e741bd4fded1337c09a82be1d1b2401e45a67e" => :mavericks
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
