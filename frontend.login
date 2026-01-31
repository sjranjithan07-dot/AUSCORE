"use client"

import { useForm } from "react-hook-form"
import { z } from "zod"
import { zodResolver } from "@hookform/resolvers/zod"
import { useRouter } from "next/navigation"

const schema = z.object({
  email: z.string().email("Enter valid email"),
  password: z.string().min(6, "Minimum 6 characters"),
})

type LoginForm = z.infer<typeof schema>

export default function LoginPage() {
  const router = useRouter()

  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<LoginForm>({
    resolver: zodResolver(schema),
  })

  const onSubmit = async (data: LoginForm) => {
    const res = await fetch("http://127.0.0.1:5000/api/login", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(data),
    })

    const result = await res.json()

    if (result.success) {
      localStorage.setItem("session", "true")
      router.push("/dashboard")
    } else {
      alert("Invalid demo credentials")
    }
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-[#1e1b4b] to-[#0f0f23]">
      <div className="w-full max-w-md p-8 rounded-xl backdrop-blur-xl bg-white/5 border border-white/10">
        <h1 className="text-2xl font-bold text-center mb-6 text-white">
          Web Scraper Pro
        </h1>

        <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
          <div>
            <input
              {...register("email")}
              placeholder="Email"
              className="w-full p-3 rounded bg-black/30 text-white outline-none"
            />
            <p className="text-red-400 text-sm">{errors.email?.message}</p>
          </div>

          <div>
            <input
              type="password"
              {...register("password")}
              placeholder="Password"
              className="w-full p-3 rounded bg-black/30 text-white outline-none"
            />
            <p className="text-red-400 text-sm">{errors.password?.message}</p>
          </div>

          <button className="w-full bg-blue-500 hover:bg-blue-600 transition p-3 rounded text-white font-semibold">
            Login
          </button>
        </form>

        <p className="text-xs text-center mt-4 text-white/60">
          Demo: demo@scraper.com / demo123
        </p>
      </div>
    </div>
  )
}
