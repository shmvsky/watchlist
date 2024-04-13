<template>
	<div class="h-75">
		<div class="input-group">
			<input type="text" 
				class="form-control name-input"
				placeholder="Имя автора"
				v-model="name">
			<button class="btn btn-success btn-sm" v-if="authorIsEditing" @click="updateAuthor"><fa icon="check"/></button>
			<button class="btn btn-danger btn-sm" v-if="authorIsEditing" @click="cancelAuthorEdit"><fa icon="x"/></button>
			<button class="btn btn-success btn-sm" v-else @click="createAuthor"><fa icon="check"/></button>
		</div>

		<div class="overflow-auto h-75 mt-2">
			<ul class="list-group list-group-flush">
				<li v-for="author in authors" :key="author.id" class="text-bg-light list-group-item d-flex justify-content-between align-items-center">
					{{ author.name }}
					<div class="d-flex flex-row gap-2">
						<span class="badge text-bg-primary rounded-pill" @click="editAuthor(author.id)"><fa icon="edit"/></span>
						<span class="badge text-bg-danger rounded-pill" @click="deleteAuthor(author.id)"><fa icon="trash"/></span>
					</div>
				</li>
			</ul>
		</div>
	</div>
</template>
	
<script setup>
    import { ref, onMounted } from 'vue';

    const authors = ref([])
    const name = ref('')
    const author_id = ref(0)
    const authorIsEditing = ref(false)
    const API_URL = "http://localhost:3000/authors";


    onMounted(async() => {
        const res = await fetch(API_URL)
        authors.value = await res.json()
    })


    const createAuthor = async() => {
        const res = await fetch(API_URL, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                name: name.value
            })
        })

        const data = await res.json()

        authors.value.push(data)
        name.value = ''
        author_id.value = 0;
    }

    const updateAuthor = async() => {
        const res = await fetch (`${API_URL}/${author_id.value}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                name: name.value,
                id: author_id.value
            })
        })

        const data = await res.json()

        const index = authors.value.findIndex(author => author.id === data.id)
        authors.value[index] = data

        name.value = ''
        author_id.value = 0;
        authorIsEditing.value = false
    }

    const cancelAuthorEdit = () => {
        name.value = ''
        author_id.value = 0;
        authorIsEditing.value = false
    }

    const deleteAuthor = async(id) => {
        await fetch (`${API_URL}/${id}`, {
            method: 'DELETE'
        })
        authors.value = authors.value.filter(author => author.id !== id)
    }

    const editAuthor = async(id) => {
        const author = authors.value.find(author => author.id === id)

        name.value = author.name
        author_id.value = author.id
        authorIsEditing.value = true

        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        })
    }
</script>