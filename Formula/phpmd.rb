require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpmd < AbstractPhpPhar
  init
  desc "PHP Mess Detector"
  homepage "http://phpmd.org"
  url "http://static.phpmd.org/php/2.4.2/phpmd.phar"
  sha256 "3d068f78fee181406679bb27db79f866e9d97cda2978a055e8a83defdb1fc02c"
  head "https://github.com/phpmd/phpmd.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "a8361d3d28fc1112a69a15ced34e84c9265d9c797f65aec1774c648ba1712138" => :el_capitan
    sha256 "ed0d335b5091175f9ac30b5abc4f4421d4c4e52ce1356a775c27df7968945d1b" => :yosemite
    sha256 "1cff56129e811173c2a502df3e638fb632bb3239c435306724f8763c597b4783" => :mavericks
  end

  test do
    system "phpmd", "--version"
  end
end
