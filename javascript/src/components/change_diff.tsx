import React from "react"
import ReactDiffViewer, {DiffMethod} from "react-diff-viewer"
import {Version} from "../types"

// maybe render this only when in the viewport if performance is bad for
// a high number of records
export const ChangeDiff: React.FC<{changeset: Version["changeset"]}> = ({
  changeset,
}) => (
  <>
    {Object.entries(changeset).map(([k, [before, after]]) => {
      // some data is nested, e.g. description translations
      if (after && typeof after === "object") {
        const beforeObj = new Object(before) as Record<string, unknown>
        const afterObj = new Object(after) as Record<string, unknown>
        const keys = [
          ...new Set(Object.keys(beforeObj).concat(Object.keys(afterObj))),
        ]
        return (
          <React.Fragment key={k}>
            {keys.map((subK) => (
              <Diff
                key={subK}
                name={`${k}_${subK}`}
                before={beforeObj[subK]}
                after={afterObj[subK]}
              />
            ))}
          </React.Fragment>
        )
      }
      // normal case: non-nested data
      return <Diff key={k} name={k} before={before} after={after} />
    })}
  </>
)

const Diff: React.FC<{name: string; before: unknown; after: unknown}> = ({
  name,
  before,
  after,
}) => {
  return (
    <>
      <strong>{name}</strong>
      <ReactDiffViewer
        compareMethod={DiffMethod.SENTENCES}
        extraLinesSurroundingDiff={2}
        // split HTML into lines for better diff results
        oldValue={String(before || "").replace(/</g, "\n<")}
        newValue={String(after || "").replace(/</g, "\n<")}
        showDiffOnly
        splitView={false}
      />
    </>
  )
}
