atom_feed do |feed|
  feed.title("Changes")
  date = @versions.first.try(:created_at) || Time.at(0)
  feed.updated(date)

  @versions.each do |version|
    next unless change_show_allowed?(version)

    feed.entry(version, :url => change_url(version)) do |entry|
      changes = changes_for(version)
      user = Member.find(version.whodunnit) rescue nil

      entry.title "#{version.event.upcase} #{version.item_type} «#{change_title_for(version)}» #{user ? 'by '+user.name : ''}"
      entry.updated version.created_at.utc.xmlschema

      xm = ::Builder::XmlMarkup.new
      xm.div {
        xm.p {
          xm.span << 'Go to: '
          xm.span << link_to('Change', change_url(version))
          xm.span << ' | '
          xm.span << link_to('Record', change_item_url(version))
        }
        xm.table {
          changes.keys.sort.each do |key|
            xm.tr {
              xm.td { xm.b key }
              xm.td changes[key][:previous].inspect
              xm.td { xm.span << "&rarr;" }
              xm.td changes[key][:current].inspect
            }
          end
        }
      }

      entry.content(xm.to_s, :type => 'html')
    end
  end
end
