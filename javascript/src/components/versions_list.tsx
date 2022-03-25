import React, {useCallback} from "react"
import {Version, stickyStyle, Config, ViewedList} from "../types"
import {ChangeDiff} from "./change_diff"
import {FullObjectModal} from "./full_object_modal"

export const VersionsList: React.FC<{
  config: Config
  loading: boolean
  versions: Array<Version>
}> = ({config, loading, versions}) => {
  if (loading) return <Info text="⌛" />

  if (versions.length === 0) return <Info text="No versions found." />

  const {columns, viewed, setViewed} = config

  return (
    <table className="table">
      <thead style={{...stickyStyle, top: 47}}>
        <tr>
          {columns.version_id && <th>Version ID</th>}
          {columns.item_type && <th>Item Type</th>}
          {columns.item_id && <th>Item ID</th>}
          {columns.event && <th>Event</th>}
          {columns.whodunnit && <th>Whodunnit</th>}
          {columns.time && <th>Time</th>}
          {columns.changes && <th>Changes</th>}
          {columns.actions && (
            <th>
              Actions&nbsp;
              <Undo config={config} />
            </th>
          )}
        </tr>
      </thead>

      <tbody>
        {versions.map((v, i) => {
          if (viewed.includes(v.id)) return null

          return (
            <tr key={i} data-ci-type="version-row">
              {columns.version_id && <td>{v.id}</td>}
              {columns.item_type && <td>{v.item_type}</td>}
              {columns.item_id && <td>{v.item_id}</td>}
              {columns.event && <td>{v.event}</td>}
              {columns.whodunnit && <TdWhodunnit v={v} />}
              {columns.time && <TdTime v={v} />}
              {columns.changes && <TdChanges v={v} />}
              {columns.actions && (
                <TdActions viewed={viewed} setViewed={setViewed} v={v} />
              )}
            </tr>
          )
        })}
      </tbody>
    </table>
  )
}

const Info = ({text}: {text: string}) => (
  <p className="d-flex justify-content-center">{text}</p>
)

const Undo = ({config: {viewed, setViewed}}: {config: Config}) => {
  const undo = useCallback(() => {
    setViewed(viewed.slice(0, -1))
  }, [viewed, setViewed])

  return (
    <span
      style={viewed.length === 0 ? {visibility: "hidden"} : {}}
      onClick={() => undo()}
    >
      ⏪
    </span>
  )
}

const TdWhodunnit = ({v}: {v: Version}) => (
  <td>
    {(v.whodunnit && (
      <a href={v.user_url || "#"} title={v.whodunnit}>
        {truncate(v.whodunnit, 8)}
      </a>
    )) ||
      "–"}
  </td>
)

const TdTime = ({v}: {v: Version}) => (
  <td>{v.created_at.replace("T", " ").replace(/\+.*/, "")}</td>
)

const TdChanges = ({v}: {v: Version}) => (
  <td>{v.changeset && <ChangeDiff changeset={v.changeset} />}</td>
)

const TdActions = ({
  viewed,
  setViewed,
  v,
}: {
  viewed: ViewedList
  setViewed: Function
  v: Version
}) => (
  <td>
    <div className="d-flex flex-column">
      <div onClick={() => setViewed([...viewed, v.id])}>
        <input type="checkbox" checked={false} />
        &nbsp;
        <span>Viewed</span>
      </div>
      {v.object && <FullObjectModal object={v.object} title="👁️ Before" />}
      {v.changeset && (
        <FullObjectModal
          object={merge(v.object, v.changeset)}
          title="👁️ After"
        />
      )}
      {v.item_url && (
        <a href={v.item_url} style={{textDecoration: "none"}} target="_blank">
          ↗️ See live
        </a>
      )}
    </div>
  </td>
)

const truncate = (str: string, len: number) => {
  if (!str || str.length <= len) return str
  return str.substring(0, len) + "…"
}

const merge = (object: Version["object"], changeset: Version["changeset"]) => {
  const newState = {...object}
  Object.entries(changeset).forEach(([k, [_, newValue]]) => {
    newState[k] = newValue
  })
  return newState
}
