import React, {useEffect, useMemo, useState} from "react"
import {render} from "react-dom"
import {FieldValues, SubmitHandler, useForm} from "react-hook-form"
import {Controls, Pagination, VersionsList} from "./components"
import {ColumnPicks} from "./types"

document.addEventListener("DOMContentLoaded", () => {
  const el = document.getElementById("mount-paper-trail-viewer")
  el && render(<App />, el)
})

const App = () => {
  const initialParams = useInitialParamsFromURL()

  const {register, handleSubmit, watch, setValue} = useForm({
    defaultValues: initialParams,
  })

  const [loading, setLoading] = useState(true)
  const [data, setData] = useState({
    hasNextPage: false,
    versions: [],
  })
  const config = useConfig(initialParams)

  const submit: SubmitHandler<FieldValues> = (params) => {
    // put form params into current URL
    const newURL = new URL(window.location.href.replace(/\?.*/, ""))
    Object.entries(params).forEach(
      ([k, v]) => v && newURL.searchParams.set(k, v)
    )
    window.history.replaceState({}, "", newURL)

    // call API to fetch matching versions
    fetch(`${window.location.pathname}/versions?${newURL.searchParams}`)
      .then((response) => response.json())
      .then((data) => {
        setData(data)
        setLoading(false)
      })
  }

  useEffect(() => submit(initialParams), [initialParams])

  return (
    <div className="p-2">
      <Controls
        config={config}
        onSubmit={handleSubmit(submit)}
        register={register}
      />

      <VersionsList
        config={config}
        loading={loading}
        versions={data.versions}
      />

      <Pagination
        hasNext={data.hasNextPage}
        onPageChange={(newPage: number) => {
          setValue("page", newPage)
          handleSubmit(submit)()
        }}
        page={watch("page")}
      />
    </div>
  )
}

const useInitialParamsFromURL = () =>
  useMemo(() => {
    const search = new URLSearchParams(window.location.search)

    return {
      event: search.get("event") || "",
      filter: search.get("filter") || "",
      item_id: search.get("item_id") || "",
      item_type: search.get("item_type") || "",
      page: parseInt("" + search.get("page")) || 1,
      per_page: parseInt("" + search.get("per_page")) || 20,
    }
  }, [])

const useConfig = (initialParams: Record<string, unknown>) => {
  const [columns, setColumns] = useState({
    actions: true,
    changes: true,
    event: true,
    item_id: !initialParams.item_id,
    item_type: !initialParams.item_type,
    time: false,
    version_id: true,
    whodunnit: true,
  } as ColumnPicks)

  const [viewed, setViewed] = useState([])

  return {columns, setColumns, viewed, setViewed}
}
