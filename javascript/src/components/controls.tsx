import React from "react"
import {Config, stickyStyle} from "../types"
import {ConfigModal} from "./config_modal"

export const Controls: React.FC<{
  register: (
    x: "page" | "filter" | "event" | "item_id" | "item_type" | "per_page"
  ) => void
  onSubmit: React.FormEventHandler<HTMLFormElement>
  config: Config
}> = ({register, onSubmit, config}) => (
  <nav
    className="d-flex align-items-md-center py-2 justify-content-center"
    style={{...stickyStyle, top: 0}}
  >
    <form className="m-0" onSubmit={onSubmit}>
      <span className="mx-1">Versions of:</span>
      <input
        {...register("item_type")}
        type="text"
        placeholder="Model"
        style={{width: 150}}
      />
      <span className="mx-1">#</span>
      <input
        {...register("item_id")}
        type="text"
        placeholder="id"
        style={{width: 110}}
      />
      <span className="mx-1">Per page:</span>
      <select {...register("per_page")}>
        <option value={20}>20</option>
        <option value={50}>50</option>
        <option value={100}>100</option>
        <option value={200}>200</option>
      </select>
      <span className="mx-1">Event:</span>
      <select {...register("event")}>
        <option value="">any</option>
        <option value="create">create</option>
        <option value="update">update</option>
        <option value="destroy">destroy</option>
      </select>
      <span className="mx-1">Filter:</span>
      <input
        {...register("filter")}
        type="text"
        placeholder="e.g. field name/value"
        style={{width: 170}}
      />
      <button
        name="button"
        type="submit"
        className="btn btn-sm btn-primary mx-1"
      >
        Search
      </button>
      <ConfigModal config={config} />
    </form>
  </nav>
)
