namespace :parse do
  desc "Parse anison.fm"
  task take_urls: :environment do
    require "nokogiri"
    require "open-uri"

    links = Array.new
    url = "http://anison.fm";
    html = Nokogiri::HTML(open(url))

    html.css(".anison_catalog a").each do |catalog|
      links.push(catalog["href"])
    end

    links = links.drop(1)
    anime_links = Array.new

    links.each do |link|
      cur_html = Nokogiri::HTML(open(url+link))
      cur_html.css(".anime_list .item").each do |anime_name|
        anime_links.push(anime_name.css("a")[0]["href"])
      end
    end

    i=0
    anime_links.each do |link|
      i+=1
      cur_html = Nokogiri::HTML(open(url+link))
      poster_link = cur_html.css(".anime_details .poster img")[0]["src"]
      title_ru = cur_html.css(".title").text
      title_orig = cur_html.css(".title_alt").text

      if (title_orig.empty?)
        title_orig = title_ru
      end

      cur_html.css(".album").each do |album|
        album_name = album.css(".head .title")[0].text
        album.css(".tracklist .titem").each do |song|
          song_name = song.css(".song_item a")[0].text
          song_prepare = song.css(".song_item")[0]["data-song"]
          song_link = "/resources/preplay/#{song_prepare}.mp3"
          Info.create(title_ru: title_ru, title_orig: title_orig, poster_link: poster_link, album_name: album_name, song_name: song_name, song_link: song_link)
        end
      end

    end

  end

  task make_json: :environment do
    file = File.open(File.join(Rails.root, "db", "export", "audio_info.json"), 'w')
    file.write(Info.all.to_json)
    file.close()
  end
end
