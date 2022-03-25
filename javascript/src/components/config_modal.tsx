import React from "react"
import {Config, availableColumns} from "../types"
import {Modal} from "./modal"

export const ConfigModal: React.FC<{
  config: Config
}> = ({config: {columns, setColumns}}) => (
  <Modal trigger="⚙️">
    <h4>Settings</h4>
    <h5>Columns</h5>
    <ul>
      {availableColumns.map((col, i) => (
        <li
          key={i}
          onClick={() => setColumns({...columns, [col]: !columns[col]})}
        >
          <input type="checkbox" checked={columns[col]} /> {col}
        </li>
      ))}
    </ul>
  </Modal>
)
