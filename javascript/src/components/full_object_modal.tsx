import React from "react"
import {Version} from "../types"
import {Modal} from "./modal"

export const FullObjectModal: React.FC<{
  object: Version["object"]
  title: string
}> = ({object, title}) => (
  <Modal trigger={title}>
    <table className="table">
      <tbody>
        {Object.entries(object).map(([k, v]) => (
          <tr key={k}>
            <th>{k}</th>
            <td>{String(v || "")}</td>
          </tr>
        ))}
      </tbody>
    </table>
  </Modal>
)
