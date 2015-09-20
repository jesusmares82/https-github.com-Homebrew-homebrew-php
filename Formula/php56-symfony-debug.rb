require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56SymfonyDebug < AbstractPhp56Extension
  init
  homepage 'http://symfony.com/'
  url 'https://github.com/symfony/Debug/archive/v2.6.0.tar.gz'
  sha256 '00bfc3c279ee1fd10eb8f771e4a3cca988cf4eb0f1bda88fcd595e5149f32a28'
  head 'https://github.com/symfony/Debug.git'

  bottle do
    cellar :any_skip_relocation
    sha256 "2545b865f036ca8f8be7130507b6cebb66c2f777810e19dfc72e037e68cfb510" => :el_capitan
    sha256 "223be6709ab629fafff644862099b5791b4f5f255805385468f2391883d73992" => :yosemite
    sha256 "3756f60e3e8a62f73f27f323e21ad1bd088bbfc22995f33bb3dcb5218c56918d" => :mavericks
  end

  def extension
    "symfony_debug"
  end

  def install
    ENV.universal_binary if build.universal?

    Dir.chdir 'Resources/ext' do
      safe_phpize
      system "./configure", "--prefix=#{prefix}",
             phpconfig
      system "make"
      prefix.install %w(modules/symfony_debug.so)
    end
    write_config_file if build.with? "config-file"
  end
end
