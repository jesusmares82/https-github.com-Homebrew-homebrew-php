require File.expand_path("../../language/php", __FILE__)

class Phan < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/phan/phan"
  url "https://github.com/phan/phan/archive/0.10.2.tar.gz"
  sha256 "a255427696066bebc440ea792c63a68fc80cbfb6de5d837eaa02fbae03670054"
  head "https://github.com/phan/phan.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2449b5e1c372216c2d659fd3deb6b2c315d3ca22cd6c581d5b75b7a29547f92d" => :high_sierra
    sha256 "8f2805be90225697e2d9d059b26430ad6d344b1224bf8d56d012b9ed81e3e154" => :sierra
    sha256 "5f231fd28a620de60ed689ed8bcc4bcb349d0880b311167c9f67308616d91912" => :el_capitan
  end

  depends_on "php71-ast"
  depends_on "php71"

  conflicts_with "phan@0.9", :because => "it provivides a phan binary"
  conflicts_with "phan@0.8", :because => "it provivides a phan binary"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "#{bin}/phan", "--help"
  end
end
