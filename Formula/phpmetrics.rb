require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpmetrics < AbstractPhpPhar
  init
  desc "Static analysis tool for PHP"
  homepage "http://www.phpmetrics.org/"
  url "https://github.com/Halleck45/PhpMetrics/raw/34cf0888e7225d743fc01b467fbbd8a1d54226a6/build/phpmetrics.phar"
  version "1.4.1"
  sha256 "77fd4f29f76bf3f8c623e415ee834692077e9b49bd340a0c896f58a9697fe9a3"

  bottle do
    cellar :any_skip_relocation
    sha256 "8121faad89efa42de10fbe38d35ff53345a1e592cd7325a5c21e64399e445491" => :el_capitan
    sha256 "fb789c633a3b5289e288e9aca26be7224118048e2952cd12a8f699b45898ca2c" => :yosemite
    sha256 "20d95564479219ef95c752c1da506258ab9246c1bf1dbf137422485e1fff25ca" => :mavericks
  end

  test do
    system "phpmetrics", "--version"
  end
end
